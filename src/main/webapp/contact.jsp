<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<section style="background: #FFF8E7; min-height: 80vh; padding: 40px 0;">
<div class="container">
    <h2 class="section-title">Contact Us <span style="font-family: 'Noto Serif SC';">联系我们</span></h2>

    <c:if test="${not empty contactSuccess}">
        <div class="alert alert-success">${contactSuccess}</div>
    </c:if>
    <c:if test="${not empty contactError}">
        <div class="alert alert-danger">${contactError}</div>
    </c:if>

    <div class="row">
        <div class="col-lg-7 mb-4">
            <div class="card">
                <div class="card-body p-4">
                    <h4 style="color: #1A1A2E;">Send Us a Message 给我们留言</h4>
                    <form action="ContactServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Name 姓名 <span style="color: #C41E3A;">*</span></label>
                            <input type="text" name="name" class="form-control" value="${name}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email 邮箱 <span style="color: #C41E3A;">*</span></label>
                            <input type="email" name="email" class="form-control" value="${email}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Subject 主题</label>
                            <input type="text" name="subject" class="form-control" value="${subject}"
                                   placeholder="General Inquiry 一般咨询 / Reservation 预订 / Feedback 反馈">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Message 留言 <span style="color: #C41E3A;">*</span></label>
                            <textarea name="message" class="form-control" rows="5" required
                                      placeholder="Tell us how we can help...">${message}</textarea>
                        </div>
                        <button type="submit" class="btn btn-lg" style="background: #C41E3A; color: white;">
                            <i class="bi bi-send"></i> Send Message 发送
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card mb-3" style="border: 2px solid #D4A843;">
                <div class="card-body">
                    <h5 style="color: #C41E3A;">Restaurant Info 餐厅信息</h5>
                    <p><i class="bi bi-geo-alt" style="color: #C41E3A;"></i> <strong>Address 地址:</strong><br>
                        88 Jalan Bukit Bintang, 55100 Kuala Lumpur</p>
                    <p><i class="bi bi-telephone" style="color: #C41E3A;"></i> <strong>Phone 电话:</strong><br>
                        +60 3-2148 8888</p>
                    <p><i class="bi bi-envelope" style="color: #C41E3A;"></i> <strong>Email 邮箱:</strong><br>
                        info@jadedragon.com</p>
                    <p><i class="bi bi-clock" style="color: #C41E3A;"></i> <strong>Hours 营业时间:</strong><br>
                        Monday - Sunday: 11:00 AM - 10:00 PM</p>
                </div>
            </div>

            <div class="card" style="background: #1A1A2E; color: #FFF8E7;">
                <div class="card-body text-center">
                    <h6 style="color: #D4A843;">Follow Us 关注我们</h6>
                    <div class="mt-2">
                        <a href="#" style="color: #D4A843; font-size: 1.5rem; margin: 0 8px;"><i class="bi bi-facebook"></i></a>
                        <a href="#" style="color: #D4A843; font-size: 1.5rem; margin: 0 8px;"><i class="bi bi-instagram"></i></a>
                        <a href="#" style="color: #D4A843; font-size: 1.5rem; margin: 0 8px;"><i class="bi bi-wechat"></i></a>
                        <a href="#" style="color: #D4A843; font-size: 1.5rem; margin: 0 8px;"><i class="bi bi-tiktok"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>
