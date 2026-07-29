<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Error - Inoodex Inventory')</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="{{ asset('assets') }}/img/logo.jpg">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="{{ asset('assets') }}/css/bootstrap.min.css">
    <style>
        :root {
            --primary: #7638ff;
            --primary-hover: #6226e3;
            --bg-body: #f8f9fa;
            --text-dark: #2c3038;
            --text-muted: #6c757d;
            --border: #e9ecef;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
        }

        .error-wrapper {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 48px 40px;
            max-width: 480px;
            width: 100%;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        .error-code-badge {
            display: inline-block;
            font-size: 3.5rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
            margin-bottom: 8px;
            letter-spacing: -0.03em;
        }

        .error-tag {
            display: inline-block;
            padding: 4px 12px;
            background: rgba(118, 56, 255, 0.08);
            color: var(--primary);
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 20px;
        }

        .error-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 12px;
        }

        .error-desc {
            font-size: 0.95rem;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 32px;
        }

        .btn-custom-primary {
            background-color: var(--primary);
            color: #ffffff;
            font-weight: 600;
            padding: 10px 24px;
            border-radius: 8px;
            border: none;
            text-decoration: none;
            transition: all 0.2s ease;
            display: inline-block;
        }

        .btn-custom-primary:hover {
            background-color: var(--primary-hover);
            color: #ffffff;
        }

        .btn-custom-outline {
            background-color: #ffffff;
            color: var(--text-dark);
            font-weight: 600;
            padding: 10px 24px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            text-decoration: none;
            transition: all 0.2s ease;
            display: inline-block;
        }

        .btn-custom-outline:hover {
            background-color: #f8f9fa;
            color: var(--text-dark);
        }

        .brand-header {
            margin-bottom: 24px;
        }

        .brand-header img {
            max-height: 42px;
            width: auto;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <div class="error-wrapper">
        <div class="brand-header">
            <img src="{{ asset('assets') }}/img/logo.jpg" alt="Inoodex Inventory" onerror="this.style.display='none'">
        </div>

        <div class="error-code-badge">@yield('code', '500')</div>
        <div>
            <span class="error-tag">@yield('badge', 'Error')</span>
        </div>

        <h1 class="error-title">@yield('heading', 'Something went wrong')</h1>
        <p class="error-desc">@yield('message', 'An unexpected error occurred. Please return to the dashboard.')</p>

        <div class="d-flex gap-2 justify-content-center flex-wrap">
            <a href="{{ url('/') }}" class="btn-custom-primary">Back to Dashboard</a>
            <button onclick="window.history.back()" class="btn-custom-outline">Go Back</button>
        </div>
    </div>
</body>
</html>
