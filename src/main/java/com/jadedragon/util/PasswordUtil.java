package com.jadedragon.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {

    /**
     * Hash a password with SHA-256 + salt.
     * Returns salt:hash format for storage.
     */
    public static String hashPassword(String plainPassword) {
        try {
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hash = md.digest(plainPassword.getBytes());

            String saltStr = Base64.getEncoder().encodeToString(salt);
            String hashStr = Base64.getEncoder().encodeToString(hash);

            return saltStr + ":" + hashStr;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    /**
     * Verify a plain password against the stored salt:hash string.
     */
    public static boolean verifyPassword(String plainPassword, String storedHash) {
        try {
            String[] parts = storedHash.split(":");
            if (parts.length != 2) {
                // Fallback: direct SHA-256 comparison (for simple hash without salt)
                return simpleHash(plainPassword).equals(storedHash);
            }

            byte[] salt = Base64.getDecoder().decode(parts[0]);
            String expectedHash = parts[1];

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] actualHash = md.digest(plainPassword.getBytes());
            String actualHashStr = Base64.getEncoder().encodeToString(actualHash);

            return expectedHash.equals(actualHashStr);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    /**
     * Simple SHA-256 hash (used for seed data passwords).
     */
    public static String simpleHash(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(input.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }
}
