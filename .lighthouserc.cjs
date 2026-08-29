module.exports = {
  ci: {
    collect: {
      startServerCommand: 'pnpm preview',
      url: ['http://localhost:4173/'],
      startServerReadyPattern: 'Build successful',
    },
  },
};
