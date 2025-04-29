// This is a placeholder for a real email/SMS service integration.
// For now, just logs to the console.
function sendOtp(destination, otp) {
  // In production, integrate with SendGrid, Mailgun, Twilio, etc.
  console.log(`Sending OTP ${otp} to ${destination}`);
}

module.exports = { sendOtp };
