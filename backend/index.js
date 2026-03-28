const express = require('express');
const cors = require('cors');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 8080;

app.use(cors());
app.use(express.json());

// GET /health
app.get('/health', (req, res) => {
    res.json({ status: 'ok' });
});

// POST /generate-plan
app.post('/generate-plan', async (req, res) => {
    const { preferences, days, budget } = req.body;

    // Build the prompt for Gemini
    const prompt = `Create a ${days} day travel itinerary for Nashik.
Budget tier: ${budget}.
Preferences/Interests: ${preferences && preferences.length ? preferences.join(', ') : 'None specified'}.
Format the output as a detailed daily plan string.`;

    try {
        const apiKey = process.env.GEMINI_API_KEY;
        if (!apiKey) {
            console.error('SERVER ERROR: GEMINI_API_KEY is not defined in environment.');
            return res.status(500).json({ error: 'Server configuration error.' });
        }

        const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}`;

        const requestBody = {
            contents: [{ parts: [{ text: prompt }] }]
        };

        const response = await axios.post(url, requestBody, {
            headers: { 'Content-Type': 'application/json' }
        });

        const data = response.data;
        
        let plan = '';
        if (data && data.candidates && data.candidates.length > 0) {
            plan = data.candidates[0].content.parts[0].text;
        } else {
            plan = 'Failed to generate a plan from AI output.';
        }

        res.json({ plan });

    } catch (error) {
        console.error('Error calling Gemini API:', error?.response?.data || error.message);
        res.status(500).json({ error: 'Failed to generate plan.' });
    }
});

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
