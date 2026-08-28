module.exports = {
  ci: {
    collect: {
      startServerCommand: 'npm run dev',
      url: ['http://localhost:8888/'],
      startServerReadyPattern: 'Build successful',
    },
  },
};
