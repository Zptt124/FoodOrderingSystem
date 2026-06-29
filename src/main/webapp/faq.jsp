<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1>Frequently Asked Questions</h1>
        <p>Find answers to common questions about Jade Dragon</p>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="accordion" id="faqAccordion">

                    <!-- FAQ 1 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#faq1" aria-expanded="true" aria-controls="faq1">
                                How do I place an order?
                            </button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show"
                             aria-labelledby="headingOne" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Placing an order is simple. First, register an account or log in. Then browse our
                                menu, choose the dishes you love, and click "Add to Cart." When you are ready,
                                head to your cart, review your items, and proceed to checkout. Your order will be
                                prepared fresh by our chefs and ready for pickup or delivery.
                            </div>
                        </div>
                    </div>

                    <!-- FAQ 2 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                                What payment methods do you accept?
                            </button>
                        </h2>
                        <div id="faq2" class="accordion-collapse collapse"
                             aria-labelledby="headingTwo" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                We accept a variety of payment methods for your convenience. You can pay with
                                cash, credit or debit cards (Visa and Mastercard), Touch 'n Go eWallet, and
                                GrabPay. All digital payments are processed securely.
                            </div>
                        </div>
                    </div>

                    <!-- FAQ 3 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                                Do you offer delivery?
                            </button>
                        </h2>
                        <div id="faq3" class="accordion-collapse collapse"
                             aria-labelledby="headingThree" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Yes, we deliver within a 10 km radius of our restaurant in Bukit Bintang.
                                A delivery fee of RM 3 applies for orders under RM 50. Orders of RM 50 and
                                above qualify for free delivery. Delivery times typically range from 30 to
                                45 minutes depending on your location.
                            </div>
                        </div>
                    </div>

                    <!-- FAQ 4 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingFour">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#faq4" aria-expanded="false" aria-controls="faq4">
                                Can I customize my order?
                            </button>
                        </h2>
                        <div id="faq4" class="accordion-collapse collapse"
                             aria-labelledby="headingFour" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Absolutely. When adding an item to your cart, use the add-ons dropdown to
                                customize it. Available options include extra chili, no MSG, extra sauce,
                                and the option to add rice. If you have a special request not listed, you
                                can leave a note during checkout and we will do our best to accommodate it.
                            </div>
                        </div>
                    </div>

                    <!-- FAQ 5 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingFive">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#faq5" aria-expanded="false" aria-controls="faq5">
                                Are there vegetarian options?
                            </button>
                        </h2>
                        <div id="faq5" class="accordion-collapse collapse"
                             aria-labelledby="headingFive" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Yes, we offer a variety of vegetarian dishes. Vegetarian items are clearly
                                marked on our menu for easy identification. You can also request modifications
                                to certain dishes to make them vegetarian-friendly. If you have any dietary
                                restrictions or allergies, please let us know when ordering and our team
                                will be happy to assist.
                            </div>
                        </div>
                    </div>

                    <!-- FAQ 6 -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingSix">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#faq6" aria-expanded="false" aria-controls="faq6">
                                What is your cancellation policy?
                            </button>
                        </h2>
                        <div id="faq6" class="accordion-collapse collapse"
                             aria-labelledby="headingSix" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                You may cancel your order within 5 minutes of placing it. Once the order
                                enters preparation status, cancellations are no longer possible. If you need
                                to cancel, please contact the restaurant directly at +60 3-2148 8888 as soon
                                as possible and we will assist you promptly.
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>