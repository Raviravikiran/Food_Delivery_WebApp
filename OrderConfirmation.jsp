<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - FeastFleet</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, sans-serif;
            background: #0c0c0d;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e8e8ea;
        }

        .confirmation-container {
            background: #161619;
            border: 1px solid rgba(255,255,255,0.06);
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 90%;
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: #fc8019;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: bounce 0.6s ease-out 0.3s both;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        .success-icon svg {
            width: 40px;
            height: 40px;
            color: white;
        }

        h1 {
            color: #e8e8ea;
            margin-bottom: 15px;
            font-size: 28px;
            font-weight: 600;
        }

        .message {
            color: #b7b8be;
            margin-bottom: 40px;
            font-size: 16px;
            line-height: 1.6;
        }

        .order-details {
            background: #111113;
            border: 1px solid rgba(255,255,255,0.06);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: left;
        }

        .order-details h3 {
            color: #e8e8ea;
            margin-bottom: 15px;
            font-size: 18px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;
            color: #b7b8be;
        }

        .detail-row:last-child {
            margin-bottom: 0;
            font-weight: 600;
            color: #e8e8ea;
            border-top: 1px solid rgba(255,255,255,0.08);
            padding-top: 8px;
        }

        .btn {
            background: linear-gradient(135deg, #fc8019 0%, #ff9d4b 100%);
            color: #101010;
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(252,128,25,0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 26px rgba(252,128,25,0.38);
        }

        .btn:active {
            transform: translateY(0);
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(252, 128, 25, 0.7);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(252, 128, 25, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(252, 128, 25, 0);
            }
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="success-icon pulse">
            <svg viewBox="0 0 24 24" fill="currentColor">
                <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
            </svg>
        </div>
        
        <h1>Order Confirmed! 🎉</h1>
        <p class="message">
            Your order has been successfully placed and is being prepared. 
            You'll receive updates on your order status.
        </p>
        
        <div class="order-details">
            <h3>Order Details</h3>
            <div class="detail-row">
                <span>Order ID:</span>
                <span>#<%= request.getParameter("orderId") != null ? request.getParameter("orderId") : "N/A" %></span>
            </div>
            <div class="detail-row">
                <span>Status:</span>
                <span style="color: #fc8019; font-weight: 600;">Confirmed</span>
            </div>
            <div class="detail-row">
                <span>Estimated Delivery:</span>
                <span>30-40 minutes</span>
            </div>
        </div>
        
        <a href="GetAllResturantsServlet" class="btn">
            Continue Order
        </a>
    </div>

    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add a small delay before showing the success icon animation
            setTimeout(() => {
                document.querySelector('.success-icon').classList.add('pulse');
            }, 500);
            
            // Add click effect to button
            document.querySelector('.btn').addEventListener('click', function(e) {
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
    </script>
</body>
</html>
