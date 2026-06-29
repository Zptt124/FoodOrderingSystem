package com.jadedragon.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ContactMessage implements Serializable {
    private static final long serialVersionUID = 1L;

    private int messageId;
    private String name;
    private String email;
    private String subject;
    private String message;
    private Timestamp createdAt;

    public ContactMessage() {}

    public int getMessageId() { return messageId; }
    public void setMessageId(int messageId) { this.messageId = messageId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
