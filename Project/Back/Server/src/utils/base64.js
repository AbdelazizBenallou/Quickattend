const token = ' eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoiYWhtZWQxNDJAZ21haWwuY29tIiwicm9sZXMiOlt7InJvbGVfaWQiOjQsIm5hbWUiOiJTdHVkZW50In1dLCJwZXJtaXNzaW9ucyI6W3sicGVybWlzc2lvbl9pZCI6MTUsIm5hbWUiOiJWaWV3X1Byb2ZpbGUifSx7InBlcm1pc3Npb25faWQiOjE2LCJuYW1lIjoiRWRpdCBQcm9maWxlIn0seyJwZXJtaXNzaW9uX2lkIjoxNywibmFtZSI6Im1hcmtfYXR0ZW5kYW5jZSJ9XSwiaWF0IjoxNzcxODcxMDQzLCJleHAiOjE3NzE4NzEzNDN9.3tH0K-WHSwrvIEC3USAnFdhxaTkDv0dLNR8hRi0Liq0'
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