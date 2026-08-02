<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="Inoodex">
    <title>Inoodex Inventory — Login</title>

    <!-- Favicon -->
    <link rel="shortcut icon" href="{{ asset('assets') }}/img/logo.jpg">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="{{ asset('assets') }}/css/bootstrap.min.css">

    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="{{ asset('assets') }}/plugins/fontawesome/css/fontawesome.min.css">
    <link rel="stylesheet" href="{{ asset('assets') }}/plugins/fontawesome/css/all.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="{{ asset('assets') }}/css/style.css">

    <style>
        :root {
            --brand: #7638ff;
            --brand-dark: #5f28d6;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f6fa;
            margin: 0;
        }

        .auth-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* Left brand panel */
        .auth-brand {
            flex: 1 1 50%;
            background: linear-gradient(135deg, var(--brand) 0%, var(--brand-dark) 100%);
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            padding: 4rem;
            position: relative;
            overflow: hidden;
        }

        .auth-brand::before,
        .auth-brand::after {
            content: "";
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
        }

        .auth-brand::before {
            width: 320px;
            height: 320px;
            top: -80px;
            right: -80px;
        }

        .auth-brand::after {
            width: 220px;
            height: 220px;
            bottom: -60px;
            left: -40px;
        }

        .auth-brand .brand-content {
            position: relative;
            z-index: 2;
        }

        .auth-brand h2 {
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 1rem;
        }

        .auth-brand p {
            font-size: 1rem;
            opacity: 0.9;
            max-width: 420px;
            line-height: 1.7;
        }

        .auth-brand .feature-list {
            list-style: none;
            padding: 0;
            margin-top: 2rem;
        }

        .auth-brand .feature-list li {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            font-size: 0.95rem;
        }

        .auth-brand .feature-list i {
            background: rgba(255, 255, 255, 0.2);
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        /* Right form panel */
        .auth-form-panel {
            flex: 1 1 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .auth-card {
            width: 100%;
            max-width: 410px;
        }

        .auth-card .logo-box {
            text-align: center;
            margin-bottom: 1.75rem;
        }

        .auth-card .logo-box img {
            height: 56px;
            border-radius: 10px;
        }

        .auth-card h1 {
            font-size: 1.6rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 0.35rem;
        }

        .auth-card .subtitle {
            color: #6b7280;
            font-size: 0.92rem;
            margin-bottom: 1.75rem;
        }

        .auth-card label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #374151;
            margin-bottom: 0.4rem;
        }

        .auth-card .form-control {
            border-radius: 10px;
            padding: 0.7rem 0.9rem;
            border: 1px solid #e2e5ec;
            font-size: 0.95rem;
        }

        .auth-card .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(118, 56, 255, 0.12);
        }

        .pass-group {
            position: relative;
        }

        .pass-group .toggle-password {
            position: absolute;
            top: 50%;
            right: 14px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #9ca3af;
        }

        .btn-auth {
            background: var(--brand);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            font-weight: 600;
            font-size: 0.98rem;
            color: #fff;
            width: 100%;
            transition: background 0.2s ease, transform 0.15s ease;
        }

        .btn-auth:hover {
            background: var(--brand-dark);
            transform: translateY(-1px);
            color: #fff;
        }

        .auth-footer {
            text-align: center;
            margin-top: 1.75rem;
            font-size: 0.85rem;
            color: #9ca3af;
        }

        @media (max-width: 991px) {
            .auth-brand {
                display: none;
            }

            .auth-form-panel {
                flex-basis: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="auth-wrapper">

        <!-- Brand Panel -->
        <div class="auth-brand">
            <div class="brand-content">
                <h2>Inoodex Inventory</h2>
                <p>Manage your sales, purchases, stock, projects and finances — all in one powerful dashboard.</p>
                <ul class="feature-list">
                    <li><i class="fas fa-boxes-stacked"></i> Real-time inventory tracking</li>
                    <li><i class="fas fa-file-invoice-dollar"></i> Instant invoices &amp; quotations</li>
                    <li><i class="fas fa-chart-line"></i> Insightful sales &amp; finance reports</li>
                </ul>
            </div>
        </div>

        <!-- Form Panel -->
        <div class="auth-form-panel">
            <div class="auth-card">
                <div class="logo-box">
                    <img src="{{ asset('assets') }}/img/logo.jpg" alt="Inoodex Logo">
                </div>

                <h1>Welcome back</h1>
                <p class="subtitle">Please sign in to access your dashboard</p>

                @if ($errors->any())
                <div class="alert alert-danger py-2 rounded-3 small">
                    {{ $errors->first() }}
                </div>
                @endif

                <form method="post" action="{{ route('login') }}">
                    @csrf
                    <div class="mb-3">
                        <label class="form-label" for="email">Email Address</label>
                        <input type="email" name="email" id="email" class="form-control"
                            value="{{ old('email') }}" placeholder="you@example.com" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="password">Password</label>
                        <div class="pass-group">
                            <input type="password" name="password" id="password"
                                class="form-control pass-input" placeholder="Enter your password" required>
                            <span class="fas fa-eye toggle-password"></span>
                        </div>
                    </div>

                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" name="remember" id="remember">
                            <label class="form-check-label small fw-normal" for="remember">Remember me</label>
                        </div>
                    </div>

                    <button class="btn-auth" type="submit">Sign In</button>
                </form>

                <div class="auth-footer">
                    &copy; {{ date('Y') }} Inoodex Inventory. All rights reserved.
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="{{ asset('assets') }}/js/jquery-3.7.1.min.js"></script>
    <!-- Bootstrap Core JS -->
    <script src="{{ asset('assets') }}/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var toggle = document.querySelector('.toggle-password');
            if (toggle) {
                toggle.addEventListener('click', function() {
                    var input = document.querySelector('.pass-input');
                    this.classList.toggle('fa-eye');
                    this.classList.toggle('fa-eye-slash');
                    input.type = input.type === 'password' ? 'text' : 'password';
                });
            }
        });
    </script>
</body>

</html>