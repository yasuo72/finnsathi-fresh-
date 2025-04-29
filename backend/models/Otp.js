const mongoose = require('mongoose');

const otpSchema = new mongoose.Schema({
  key: { type: String, required: true, unique: true }, // email or mobile
  otp: { type: String, required: true },
  createdAt: { type: Date, default: Date.now, expires: 600 } // 10 min expiry
});

module.exports = mongoose.model('Otp', otpSchema);
