#!/usr/bin/env python3
from flask import Flask, request, render_template_string, send_file
import os

app = Flask(__name__)

FLAG_PATH = "/opt/app1/flag.txt"

TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Python Vulnerable App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #1a1a1a; color: #eee; }
        .container { margin-top: 60px; }
        .card { background: #262626; border-radius: 12px; }
        .footer { margin-top: 40px; color: #777; font-size: 0.9rem; }
    </style>
</head>
<body>

<div class="container">
    <div class="card p-4">
        <h2 class="text-info">🐍 Python Vulnerable Web App</h2>
        <p class="text-secondary">This app contains multiple vulnerabilities:</p>

        <ul>
            <li><b>/flag</b> — Read the flag file</li>
            <li><b>/read?file=flag.txt</b> — LFI (Local File Inclusion)</li>
            <li>Try: <code>/read?file=../../../../etc/passwd</code></li>
        </ul>

        <hr />

        <h5 class="text-warning">Try File Read (LFI)</h5>
        <form method="GET" action="/read">
            <div class="input-group">
                <input class="form-control" name="file" placeholder="flag.txt or ../../etc/passwd">
                <button class="btn btn-danger">Read File</button>
            </div>
        </form>
    </div>

    <div class="footer text-center">CTF Training Environment — Python App</div>
</div>

</body>
</html>
"""

@app.route("/")
def home():
    return render_template_string(TEMPLATE)

@app.route("/flag")
def flag():
    return send_file(FLAG_PATH)

@app.route("/read")
def read_file():
    file = request.args.get("file")
    if not file:
        return "Missing ?file parameter", 400
    
    full = os.path.join("/opt/app1", file)

    try:
        return send_file(full)
    except Exception as e:
        return f"Error reading file: {e}", 500

app.run(host="0.0.0.0", port=8080)
