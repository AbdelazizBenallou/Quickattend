const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIyLCJlbWFpbCI6ImF6aXpnZ2F6aTQ0ejExMTExMTRAZ21haWwuY29tIiwicm9sZXMiOlsiU3R1ZGVudCJdLCJpYXQiOjE3NzI1NzcyMzcsImV4cCI6MTc3MjU3NzUzN30.gBXVEsN3Y2ykCZYmnGYsgUNjoa2X6zW6P1024sDQAPk'
function decodeJwt(token) {
  try {
    const payloadBase64 = token.split('.')[1];
    // Add padding if needed (Base64 requires length % 4 === 0)
    const padded = payloadBase64.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = Buffer.from(padded, 'base64').toString('utf8');
    return JSON.parse(jsonPayload);
  } catch (e) {
    throw new Error('Invalid JWT');
  }
}

const payload = decodeJwt(token);
console.log(payload);