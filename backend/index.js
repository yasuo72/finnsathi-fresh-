require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const { User, Otp, generateOTP } = require('./store');
const { generateToken, authMiddleware } = require('./jwt');
const { sendOtp } = require('./notification');

const app = express();
const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI;

app.use(cors());
app.use(bodyParser.json());

// MongoDB connection
mongoose.connect(MONGO_URI)
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.error('MongoDB connection error:', err));

// Health check
app.get('/', (req, res) => {
  res.send('Finsaathi Multi Backend is running!');
});

// Sign Up
app.post('/api/signup', async (req, res) => {
  const { name, dob, email, password, mobile } = req.body;
  if (!email && !mobile) return res.status(400).json({ message: 'Email or mobile required' });
  try {
    const existing = await User.findOne({ $or: [ { email }, { mobile } ] });
    if (existing) return res.status(409).json({ message: 'User already exists' });
    const user = new User({ name, dob, email, password, mobile, verified: false });
    await user.save();
    // Generate & save OTP
    const otp = generateOTP();
    await Otp.findOneAndUpdate(
      { key: email || mobile },
      { otp, createdAt: new Date() },
      { upsert: true }
    );
    sendOtp(email || mobile, otp);
    console.log(`OTP for ${email || mobile}: ${otp}`);
    res.json({ message: 'User registered, OTP sent' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// Sign In
app.post('/api/signin', async (req, res) => {
  const { email, password, mobile } = req.body;
  try {
    const user = await User.findOne({ $or: [ { email }, { mobile } ], password });
    if (!user) return res.status(401).json({ message: 'Invalid credentials' });
    if (!user.verified) return res.status(403).json({ message: 'User not verified' });
    const token = generateToken({ id: user.email || user.mobile });
    res.json({ message: 'Sign in successful', token, user: { name: user.name, email: user.email, mobile: user.mobile } });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// OTP Verification (for signup or password reset)
app.post('/api/verify', async (req, res) => {
  const { email, mobile, otp } = req.body;
  const key = email || mobile;
  try {
    const otpDoc = await Otp.findOne({ key });
    if (otpDoc && otpDoc.otp === otp) {
      await User.findOneAndUpdate({ $or: [ { email }, { mobile } ] }, { verified: true });
      await Otp.deleteOne({ key });
      return res.json({ message: 'OTP verified' });
    }
    res.status(400).json({ message: 'Invalid OTP' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// Forgot Password (request OTP)
app.post('/api/forgot-password', async (req, res) => {
  const { email, mobile } = req.body;
  const key = email || mobile;
  try {
    const user = await User.findOne({ $or: [ { email }, { mobile } ] });
    if (!user) return res.status(404).json({ message: 'User not found' });
    const otp = generateOTP();
    await Otp.findOneAndUpdate(
      { key },
      { otp, createdAt: new Date() },
      { upsert: true }
    );
    sendOtp(key, otp);
    console.log(`Password reset OTP for ${key}: ${otp}`);
    res.json({ message: 'OTP sent for password reset' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// Reset Password (after OTP)
app.post('/api/reset-password', async (req, res) => {
  const { email, mobile, otp, newPassword } = req.body;
  const key = email || mobile;
  try {
    const otpDoc = await Otp.findOne({ key });
    if (otpDoc && otpDoc.otp === otp) {
      await User.findOneAndUpdate({ $or: [ { email }, { mobile } ] }, { password: newPassword });
      await Otp.deleteOne({ key });
      return res.json({ message: 'Password reset successful' });
    }
    res.status(400).json({ message: 'Invalid OTP' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// Get user profile (JWT protected)
app.get('/api/profile', authMiddleware, async (req, res) => {
  try {
    const user = await User.findOne({ $or: [ { email: req.user.id }, { mobile: req.user.id } ] });
    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json({ name: user.name, dob: user.dob, email: user.email, mobile: user.mobile });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// Update user profile (JWT protected)
app.put('/api/profile', authMiddleware, async (req, res) => {
  try {
    const user = await User.findOne({ $or: [ { email: req.user.id }, { mobile: req.user.id } ] });
    if (!user) return res.status(404).json({ message: 'User not found' });
    const { name, dob } = req.body;
    if (name) user.name = name;
    if (dob) user.dob = dob;
    await user.save();
    res.json({ message: 'Profile updated', user: { name: user.name, dob: user.dob, email: user.email, mobile: user.mobile } });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

// Change password (JWT protected)
app.post('/api/change-password', authMiddleware, async (req, res) => {
  try {
    const user = await User.findOne({ $or: [ { email: req.user.id }, { mobile: req.user.id } ] });
    if (!user) return res.status(404).json({ message: 'User not found' });
    const { oldPassword, newPassword } = req.body;
    if (user.password !== oldPassword) return res.status(400).json({ message: 'Old password incorrect' });
    user.password = newPassword;
    await user.save();
    res.json({ message: 'Password changed successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
