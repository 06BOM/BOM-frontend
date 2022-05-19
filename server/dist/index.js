"use strict";
var __read = (this && this.__read) || function (o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
};
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// import app from "./app";
var express = require('express');
var http_1 = __importDefault(require("http")); // 이미 기본 설치되어있음
//import WebSocket from "ws"; // 기본설치!
var socket_io_1 = require("socket.io");
var app = express();
app.use(express.json());
var PORT = process.env.PORT || 3000;
var handleListening = function () {
    console.log("\u2705 Server is ready. http://localhost:".concat(PORT));
};
var httpServer = http_1.default.createServer(app);
var wsServer = new socket_io_1.Server(httpServer);
function countRoom(roomName) {
    var _a;
    return (_a = wsServer.sockets.adapter.rooms.get(roomName)) === null || _a === void 0 ? void 0 : _a.size;
}
var readyStorage = new Map();
var checkQuestionsUsage = new Map();
var firstQflag = new Map();
var answer, explanation;
var scoreListOfRooms = new Map();
var immMap, sortScores;
var question = [
    { id: 1, oxQuestion: "이 앱의 이름은 다모여이다.", oxAnswer: "o", explanation: "이 앱의 이름은 다모여가 맞다." },
    { id: 2, oxQuestion: "이 앱을 만든 조의 이름은 BOOM이다", oxAnswer: "x", explanation: "이 앱을 만든 조의 이름은 BOM이다." },
    { id: 3, oxQuestion: "이 앱을 만든 조는 6조이다.", oxAnswer: "o", explanation: "이 앱을 만든 조는 6조가 맞다." },
    { id: 4, oxQuestion: "토마토는 과일이 아니라 채소이다.", oxAnswer: "o", explanation: "토마토는 채소이다." },
    { id: 5, oxQuestion: "원숭이에게는 지문이 없다.", oxAnswer: "x", explanation: "원숭이에게도 지문이 있다." },
    { id: 6, oxQuestion: "가장 강한 독을 가진 개구리 한마리의 독으로 사람 2000명 이상을 죽일 수 있다.", oxAnswer: "o", explanation: "아프리카에 사는 식인 개구리의 독성으로 2000명의 사람을 죽일 수 있다." },
    { id: 7, oxQuestion: "달팽이는 이빨이 있다", oxAnswer: "o", explanation: "달팽이도 이빨이 있다." },
    { id: 8, oxQuestion: "고양이는 잠을 잘 때 꿈을 꾼다", oxAnswer: "o", explanation: "고양이도 잠을 잘 때 꿈을 꾼다." },
    { id: 9, oxQuestion: "물고기도 색을 구분할 수 있다.", oxAnswer: "o", explanation: "물고기도 색을 구분한다." },
    { id: 10, oxQuestion: "낙지의 심장은 3개이다", oxAnswer: "o", explanation: "낙지의 심장은 3개이다." }
];
wsServer.on("connection", function (socket) {
    socket.data.nickname = "Anon";
    socket.onAny(function (event) {
        console.log("Socket Event:".concat(event));
    });
    console.log('connection event: connected!');
    socket.on("enter_room", function (nickname, roomName) {
        if (countRoom(roomName) > 9) {
            socket.emit("message specific user", socket.id, "정원초과로 입장하실 수 없습니다.😥");
        }
        else {
            socket.data.nickname = nickname; // add
            // console.log("socket.data.nickname: ", socket.data.nickname);
            socket.join(roomName);
            console.log(socket.rooms);
            readyStorage.set(roomName, []);
            checkQuestionsUsage.set(roomName, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
            var immScoreMap = new Map();
            if (scoreListOfRooms.has(roomName)) {
                immScoreMap = scoreListOfRooms.get(roomName);
            }
            immScoreMap.set(socket.data.nickname, 0);
            scoreListOfRooms.set(roomName, immScoreMap);
            console.log("1. scoreListOfRooms: ", scoreListOfRooms);
            socket.to(roomName).emit("welcome", socket.data.nickname, roomName, countRoom(roomName));
        }
    });
    socket.on("new_message", function (msg, room, done) {
        socket.to(room).emit("new_message", "".concat(socket.data.nickname, ": ").concat(msg));
        done();
    });
    socket.on("ready", function (roomName) {
        var _a;
        var roomReadyArr = readyStorage.get(roomName);
        console.log(roomReadyArr);
        if (!roomReadyArr.includes(socket.id)) {
            roomReadyArr.push(socket.id);
            readyStorage.set(roomName, roomReadyArr);
            console.log(readyStorage.get(roomName));
        }
        else {
            var removeIdArr = roomReadyArr.filter(function (element) { return element !== socket.id; });
            console.log(removeIdArr);
            readyStorage.set(roomName, removeIdArr);
            console.log(readyStorage.get(roomName));
        }
        roomReadyArr = readyStorage.get(roomName);
        if (roomReadyArr.length === ((_a = wsServer.sockets.adapter.rooms.get(roomName)) === null || _a === void 0 ? void 0 : _a.size)) {
            wsServer.sockets.in(roomName).emit("ready");
        }
        else {
            wsServer.sockets.in(roomName).emit("ready check");
        }
    });
    socket.on("ready check", function (roomName) {
        var _a;
        if ((readyStorage.get(roomName)).length === ((_a = wsServer.sockets.adapter.rooms.get(roomName)) === null || _a === void 0 ? void 0 : _a.size)) {
            console.log("h");
            wsServer.sockets.emit("ready");
        }
    });
    socket.on("gameStart", function (roomName) {
        firstQflag.set(roomName, 0);
        immMap = new Map(scoreListOfRooms.get(roomName));
        wsServer.sockets.in(roomName).emit("scoreboard display", JSON.stringify(Array.from(immMap)));
        wsServer.sockets.in(roomName).emit("showGameRoom");
    });
    socket.on("question", function (roomName) {
        var cnt = 0;
        console.log("checkQuestionsUsage: ", checkQuestionsUsage);
        console.log("firstQflag: ", firstQflag);
        for (var i = 0; i < 10; i++) {
            if (checkQuestionsUsage.get(roomName)[i] === 1) {
                cnt++;
            }
            if (cnt >= 10) {
                return;
            }
        }
        if (firstQflag.get(roomName) === 0) { //flag 0: 가장 첫번째 실행한 사람만 아래 코드 실행
            firstQflag.set(roomName, 1);
        }
        else {
            return;
        }
        var index = Math.floor(Math.random() * 10);
        while (checkQuestionsUsage.get(roomName)[index]) {
            console.log("in here");
            index = Math.floor(Math.random() * 10);
        }
        checkQuestionsUsage.get(roomName)[index] = 1;
        answer = question[index].oxAnswer;
        explanation = question[index].explanation;
        console.log(question[index].oxQuestion);
        wsServer.sockets.in(roomName).emit("round", question[index].oxQuestion, index);
        wsServer.sockets.in(roomName).emit("timer");
    });
    socket.on("ox", function (payload) {
        socket.data.ox = payload.ox;
        wsServer.sockets.emit("ox", { answer: payload.ox, userId: payload.userId });
    });
    socket.on("answer", function (roomName, done) {
        done(answer, explanation);
        firstQflag.set(roomName, 0);
    });
    socket.on("score", function (payload) {
        if (question[payload.index].oxAnswer === socket.data.ox) { //정답
            immMap = scoreListOfRooms.get(payload.roomName);
            immMap.forEach(function (value, key) {
                if (key === socket.data.nickname) {
                    immMap.set(key, Number(value) + 10);
                    socket.data.ox = "";
                }
            });
            sortScores = new Map(__spreadArray([], __read(immMap.entries()), false).sort(function (a, b) { return b[1] - a[1]; }));
            console.log("1.sortScores: ", sortScores);
            wsServer.sockets.in(payload.roomName).emit("score change", JSON.stringify(Array.from(sortScores)));
        }
    });
    socket.on("all finish", function (roomName, done) {
        sortScores = new Map(__spreadArray([], __read(immMap.entries()), false).sort(function (a, b) { return b[1] - a[1]; }));
        console.log("2.sortScores: ", sortScores);
        done(JSON.stringify(Array.from(sortScores)));
        checkQuestionsUsage.set(roomName, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        immMap = new Map(scoreListOfRooms.get(roomName));
        immMap.forEach(function (value, key) {
            immMap.set(key, 0);
        });
        scoreListOfRooms.set(roomName, immMap);
    });
    socket.on("exit_room", function (roomName, done) {
        //let roomReadyArr = readyStorage.get(roomName);
        var removeIdArr = readyStorage.get(roomName).filter(function (element) { return element !== socket.id; });
        readyStorage.set(roomName, removeIdArr);
        console.log("before checkQuestionsUsage: ", checkQuestionsUsage);
        console.log("before firstQflag: ", firstQflag);
        checkQuestionsUsage.delete(roomName);
        firstQflag.delete(roomName);
        console.log("delete checkQuestionsUsage: ", checkQuestionsUsage);
        console.log("delete firstQflag: ", firstQflag);
        socket.leave(roomName);
        socket.to(roomName).emit("bye", socket.data.nickname, roomName, countRoom(roomName));
        done();
    });
});
httpServer.listen(PORT, handleListening);
//# sourceMappingURL=index.js.map