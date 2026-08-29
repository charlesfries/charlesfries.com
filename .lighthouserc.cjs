module.exports = {
  ci: {
    collect: {
      startServerCommand: 'pnpm preview',
      url: ['http://localhost:8888/'],
      startServerReadyPattern: 'Build successful',
    },
  },
};
