const { makeWASocket, useMultiFileAuthState } = require("baileys");
const pino = require("pino");

const target = process.argv[2];
if (!target) {
    console.log("❌ Nomor target tidak diberikan!");
    process.exit(0);
}

async function start() {
    try {
        const { state, saveCreds } = await useMultiFileAuthState("./session_whatsapp");
        const sock = makeWASocket({
            auth: state,
            printQRInTerminal: false,
            logger: pino({ level: "silent" })
        });

        const pairingCode = await sock.requestPairingCode(target);
        console.log("🔑 Pairing Code:", pairingCode);

        await saveCreds();
        process.exit(0);

    } catch (err) {
        console.log("❌ Error:", err.message);
        process.exit(1);
    }
}

start();
