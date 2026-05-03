const http = require('http');
const os = require('os'); 

const server = http.createServer((req, res) => {
    const containerId = os.hostname(); 
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end(`SUCCESS! You hit the VLAN 30 Backend.\nProcessed by Container ID: [ ${containerId} ]\n`);
});

const PORT = 3000;
server.listen(PORT, () => {
    console.log(`Backend server is running on port ${PORT}`);
});