// JWT middleware for Express
const jwt = require('jsonwebtoken');
const SECRET = 'finsaathi_secret_key'; // In production, use env variable

function generateToken(payload) {
  return jwt.sign(payload, SECRET, { expiresIn: '2h' });
}

function authMiddleware(req, res, next) {
  const authHeader = req.headers['authorization'];
  if (!authHeader) return res.status(401).json({ message: 'No token provided' });
  const token = authHeader.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Invalid token format' });
  jwt.verify(token, SECRET, (err, user) => {
    if (err) return res.status(401).json({ message: 'Invalid token' });
    req.user = user;
    next();
  });
}

module.exports = { generateToken, authMiddleware };
