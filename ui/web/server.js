const http = require("http");

const html = `<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <title>FOCUS: Earthlight</title>
  <style>
    body { font-family: sans-serif; margin: 2rem; background: #111; color: #eee; }
    .grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1rem; }
    .card { border: 1px solid #444; border-radius: 10px; padding: 1rem; background: #1a1a1a; }
    h1, h2 { margin-top: 0; }
  </style>
</head>
<body>
  <h1>FOCUS: Earthlight</h1>
  <div class="grid">
    <div class="card"><h2>World State</h2><p>Candor placeholder panel.</p></div>
    <div class="card"><h2>Earth Signal Desk</h2><p>Ingest and event clustering will appear here.</p></div>
    <div class="card"><h2>Hypothesis / Audit</h2><p>Structured claim analysis and audit trail will appear here.</p></div>
  </div>
</body>
</html>`;

http.createServer((_, res) => {
  res.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
  res.end(html);
}).listen(3000, () => {
  console.log("FOCUS UI running at http://localhost:3000");
});
