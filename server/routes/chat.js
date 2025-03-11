const express = require("express");
const axios = require('axios');
const auth = require("../middlewares/auth");

const chatRouter = express.Router();
const API_KEY="AIzaSyAMFQKo9WBXjepFyc9nzixlv1lovq_BYY0";
const API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

chatRouter.post("/ask-ai", auth, async (req, res) => {
    try {
        const {msg} = req.body;
        const response = await axios.post(
            `${API_URL}?key=${API_KEY}`,
            {
              contents: [
                {
                  parts: [{ text: msg }]
                }
              ]
            },
            {
              headers: {
                'Content-Type': 'application/json'
              }
            }
          );
          
          console.log(response.data.candidates[0].content.parts[0].text);
        res.status(200).json(response.data.candidates[0].content.parts[0].text || 'lỗi')
    } catch (error) {
        res.status(500).json({error : error.message});
    }
})

module.exports = chatRouter;