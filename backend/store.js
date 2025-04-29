// In-memory user store (for demo only)
const mongoose = require('mongoose');
const User = require('./models/User');
const Otp = require('./models/Otp');

// Helper: generate random 6-digit OTP
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

module.exports = {
  User,
  Otp,
  generateOTP,
};
