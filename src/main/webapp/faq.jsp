<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<section style="background: #FFF8E7; min-height: 80vh; padding: 40px 0;">
<div class="container">
    <h2 class="section-title">FAQ <span style="font-family: 'Noto Serif SC';">常见问题</span></h2>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="accordion" id="faqAccordion">

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#faq1"
                                style="background: #FFF; color: #1A1A2E; font-weight: 600;">
                            How do I place an order? 如何下单？
                        </button>
                    </h2>
                    <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Simply register an account, browse our menu, add items to your cart,
                            and proceed to checkout. Your order will be prepared fresh by our chefs!
                            只需注册账号，浏览菜单，加入购物车，结账即可。我们的厨师将为您新鲜烹制！
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq2"
                                style="background: #FFF; color: #1A1A2E; font-weight: 600;">
                            What payment methods do you accept? 支持哪些支付方式？
                        </button>
                    </h2>
                    <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            We accept cash, credit/debit cards (Visa, Mastercard), Touch 'n Go eWallet,
                            GrabPay, and bank transfers. 我们接受现金、信用卡/借记卡、Touch 'n Go、GrabPay 和银行转账。
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq3"
                                style="background: #FFF; color: #1A1A2E; font-weight: 600;">
                            Do you offer delivery? 支持配送吗？
                        </button>
                    </h2>
                    <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Yes! We deliver within 10km of our restaurant. Orders above RM50
                            qualify for free delivery. Otherwise, a RM5 delivery fee applies.
                            是的！我们在餐厅10公里范围内配送。订单满RM50免配送费，否则收取RM5配送费。
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq4"
                                style="background: #FFF; color: #1A1A2E; font-weight: 600;">
                            Can I customize my order? 可以定制菜品吗？
                        </button>
                    </h2>
                    <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Absolutely! Use the add-ons menu when adding items to your cart.
                            Choose options like extra chili, no MSG, extra sauce, or add rice.
                            当然可以！加入购物车时使用附加选项菜单，可选择加辣、去味精、加酱料或加米饭。
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq5"
                                style="background: #FFF; color: #1A1A2E; font-weight: 600;">
                            Any allergen information? 过敏原信息？
                        </button>
                    </h2>
                    <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Each dish's ingredients and nutritional information are listed on its
                            detail page. Please inform us of any allergies when ordering.
                            每道菜的原料和营养信息都列在详情页上。下单时请告知我们任何过敏情况。
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq6"
                                style="background: #FFF; color: #1A1A2E; font-weight: 600;">
                            Can I cancel my order? 可以取消订单吗？
                        </button>
                    </h2>
                    <div id="faq6" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            Orders can only be cancelled before they enter "preparing" status.
                            Please contact us immediately if you need to cancel.
                            订单仅在进入"准备中"状态前可取消。如需取消请立即联系我们。
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>
