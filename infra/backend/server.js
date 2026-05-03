const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('SUCCESS! Welcome to the VLAN 30 Backend Application. The Master Database is next!\n');
});

const PORT = 3000;
server.listen(PORT, () => {
    console.log(`Backend server is running on port ${PORT}`);
});