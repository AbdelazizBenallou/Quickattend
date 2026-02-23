// hash-one.js
const argon2 = require('argon2');

(async () => {
  const password = '784512963'; // 👈 change this
  const hash = await argon2.hash(password, {
    type: argon2.argon2id,
    memoryCost: 65536,
    timeCost: 3,
    parallelism: 4
  });
  console.log('Hash:', hash);
})();