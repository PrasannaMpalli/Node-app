const express = require("express");
require("dotenv").config();
const app = express();

const path = require("path");
app.use(express.static(path.join(__dirname, "public")));

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/index.html");
});

app.get("/login", (req, res) => {
  res.sendFile(__dirname + "/public/login.html", {
    apiKey: process.env.SAWO_API_KEY,
  });
});

app.get("/success", (req, res) => {
  res.sendFile(__dirname + "/public/success.html");
});

const port = process.env.PORT || 3000;

app.listen(port, console.log("Listening on port" + process.env.HOST));
