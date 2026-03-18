const express = require('express');
const cors = require('cors');
const fetch = require('node-fetch');

const app = express();
const PORT = process.env.PORT || 3000;
const API_KEY = process.env.ANTHROPIC_API_KEY;

app.use(cors());
app.use(express.json({ limit: '20mb' }));

// Serve nexus.html tại /
app.use(express.static('public'));

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', name: 'Nexus AI Server' });
});

// Proxy API Claude
app.post('/api/chat', async (req, res) => {
  if (!API_KEY) {
    return res.status(500).json({ error: { message: 'API key chưa được cấu hình trên server.' } });
  }

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': API_KEY,
        'anthropic-version': '2023-06-01',
        'anthropic-beta': 'interleaved-thinking-2025-05-14'
      },
      body: JSON.stringify(req.body)
    });

    const data = await response.json();
    res.json(data);

  } catch (err) {
    res.status(500).json({ error: { message: 'Lỗi server: ' + err.message } });
  }
});

app.listen(PORT, () => {
  console.log(`✅ Nexus AI Server đang chạy tại port ${PORT}`);
});
