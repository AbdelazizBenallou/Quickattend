const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMwLCJlbWFpbCI6InlvdW5iN2VzYmVsQGdtYWlsLmNvbSIsInJvbGVzIjpbIlN0dWRlbnQiXSwiaWF0IjoxNzcyNjMwODE3LCJleHAiOjE3NzI2MzExMTd9.jgWDVabXAzsZ40LebFi9ZW5lStkRwDgmkqv7HqRjChI'

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