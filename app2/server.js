const express = require("express");
const fs = require("fs");
const { exec } = require("child_process");

const app = express();
const FLAG_PATH = "/opt/app2/flag.txt";

const PAGE = `
<!DOCTYPE html>
<html>
<head>
    <title>NodeJS Vulnerable App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #101010; color: #eee; }
        .box { background: #1e1e1e; padding: 25px; margin-top: 60px; border-radius: 12px; }
        .footer { margin-top: 40px; color: #aaa; }
    </style>
</head>
<body>

<div class="container">
    <div class="box">
        <h2 class="text-primary">🟦 Node.js Vulnerable Web App</h2>
        <p>This app contains multiple vulnerabilities:</p>

        <ul>
            <li><b>/flag</b> — Read flag.txt</li>
            <li><b>/read?file=flag.txt</b> — Local File Inclusion</li>
            <li><b>/ping?host=127.0.0.1</b> — Command Injection</li>
        </ul>

        <hr />

        <h5 class="text-warning">Try LFI</h5>
        <form action="/read" method="GET">
            <div class="input-group">
                <input class="form-control" name="file" placeholder="flag.txt or ../../etc/passwd" />
                <button class="btn btn-danger">Read</button>
            </div>
        </form>

        <hr />

        <h5 class="text-warning">Try Command Injection</h5>
        <form action="/ping" method="GET">
            <div class="input-group">
                <input class="form-control" name="host" placeholder="8.8.8.8; cat /opt/app2/flag.txt">
                <button class="btn btn-danger">Execute</button>
            </div>
        </form>

    </div>

    <div class="footer text-center">CTF Training Environment — Node.js App</div>
</div>

</body>
</html>
`;

// ROUTES

app.get("/", (req, res) => res.send(PAGE));

// Direct flag read
app.get("/flag", (req, res) => {
    const data = fs.readFileSync(FLAG_PATH, "utf8");
    res.send(`<pre>${data}</pre>`);
});

// LFI Vulnerability
app.get("/read", (req, res) => {
    const file = req.query.file;
    try {
        const data = fs.readFileSync(`/opt/app2/${file}`, "utf8");
        res.send(`<pre>${data}</pre>`);
    } catch (err) {
        res.send("Error reading file: " + err);
    }
});

// Command Injection
app.get("/ping", (req, res) =>
{
    const h = req.query.host;
    exec(`ping -c 1 ${h}`, (err, stdout, stderr) => {
        if (err) return res.send("Error: " + err);
        res.send(`<pre>${stdout}</pre>`);
    });
});

app.listen(9090, () => console.log("NodeJS vulnerable app running on port 9090"));
