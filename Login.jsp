<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FeastFleet— Login</title>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --brand: #fc8019;
      --brand-alt: #e23744;
      --bg: #0f0f10;
      --surface: #111113;
      --card: #161619;
      --muted: #7c7f87;
      --text: #e8e8ea;
      --text-weak: #b7b8be;
      --success: #26a65b;
      --warning: #ffb020;
      --radius: 14px;
      --radius-sm: 10px;
      --shadow-1: 0 6px 18px rgba(0,0,0,0.22);
      --shadow-2: 0 12px 28px rgba(0,0,0,0.26);
      --shadow-soft: 0 2px 8px rgba(0,0,0,0.18);
      --container: 1200px;
      --transition: 220ms cubic-bezier(.2,.7,.2,1);
    }

    * { box-sizing: border-box; }
    html, body {
      margin: 0;
      padding: 0;
      background: #0c0c0d;
      color: var(--text);
      font-family: "Open Sans", system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
      line-height: 1.5;
    }

    a { color: inherit; text-decoration: none; }
    img { display: block; max-width: 100%; height: auto; }

    .container {
      width: 100%;
      max-width: var(--container);
      margin: 0 auto;
      padding: 0 20px;
    }

    /* Header */
    header {
      position: sticky;
      top: 0;
      z-index: 40;
      background: rgba(14,14,16,0.88);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255,255,255,0.06);
    }
    .nav {
      display: flex;
      align-items: center;
      justify-content: space-between;
      height: 68px;
      gap: 16px;
    }
    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      font-family: "Poppins", sans-serif;
      font-weight: 700;
      letter-spacing: 0.2px;
    }
    .brand .logo {
      width: 36px;
      height: 36px;
      border-radius: 10px;
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      box-shadow: 0 8px 18px rgba(252,128,25,0.35);
      display: grid;
      place-items: center;
      color: #fff;
    }
    .brand .name { font-size: 18px; }

    /* Login Form */
    .login-container {
      min-height: calc(100vh - 68px);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px 0;
    }

    .login-card {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      padding: 40px;
      width: 100%;
      max-width: 400px;
      box-shadow: var(--shadow-2);
    }

    .login-header {
      text-align: center;
      margin-bottom: 32px;
    }

    .login-header h1 {
      font-family: "Poppins", sans-serif;
      font-size: 28px;
      margin: 0 0 8px;
    }

    .login-header p {
      color: var(--text-weak);
      margin: 0;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: var(--text);
    }

    .form-group input {
      width: 100%;
      padding: 12px 16px;
      background: rgba(255,255,255,0.04);
      border: 1px solid rgba(255,255,255,0.08);
      border-radius: var(--radius-sm);
      color: var(--text);
      font-size: 14px;
      transition: border-color var(--transition), box-shadow var(--transition);
    }

    .form-group input:focus {
      outline: none;
      border-color: var(--brand);
      box-shadow: 0 0 0 3px rgba(252,128,25,0.1);
    }

    .btn {
      width: 100%;
      padding: 14px 20px;
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      border: 0;
      border-radius: var(--radius-sm);
      color: #101010;
      font-weight: 700;
      font-family: "Poppins", sans-serif;
      font-size: 16px;
      cursor: pointer;
      transition: transform var(--transition), box-shadow var(--transition);
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(252,128,25,0.3);
    }

    .error-message {
      background: rgba(226,55,68,0.1);
      border: 1px solid rgba(226,55,68,0.3);
      color: #ffb3bb;
      padding: 12px;
      border-radius: var(--radius-sm);
      margin-bottom: 20px;
      font-size: 14px;
    }

    .signup-link {
      text-align: center;
      margin-top: 24px;
      color: var(--text-weak);
    }

    .signup-link a {
      color: var(--brand);
      font-weight: 600;
    }

    .signup-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="container nav">
      <div class="brand">
        <div class="logo" aria-hidden="true">🍽️</div>
        <div class="name">FeastFleet</div>
      </div>
    </div>
  </header>

  <!-- Login Form -->
  <main class="login-container">
    <div class="login-card">
      <div class="login-header">
        <h1>Welcome Back</h1>
        <p>Sign in to your account to continue</p>
      </div>

      <% if (request.getAttribute("error") != null) { %>
        <div class="error-message">
          <%= request.getAttribute("error") %>
        </div>
      <% } %>

      <form action="login" method="post">
        <% if (request.getParameter("redirectTo") != null) { %>
          <input type="hidden" name="redirectTo" value="<%= request.getParameter("redirectTo") %>">
        <% } %>
        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" required>
        </div>
        
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required>
        </div>

        <button type="submit" class="btn">Sign In</button>
      </form>

      <div class="signup-link">
        Don't have an account? <a href="Signup.jsp">Sign up</a>
      </div>
    </div>
  </main>

</body>
</html>
