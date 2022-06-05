"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = __importDefault(require("express"));
var morgan_1 = __importDefault(require("morgan"));
var helmet_1 = __importDefault(require("helmet"));
var path_1 = __importDefault(require("path"));
var routes_1 = __importDefault(require("./routes"));
var user_1 = __importDefault(require("./routes/user"));
var plan_1 = __importDefault(require("./routes/plan"));
var post_1 = __importDefault(require("./routes/post"));
var comment_1 = __importDefault(require("./routes/comment"));
var category_1 = __importDefault(require("./routes/category"));
var tools_1 = require("./tools");
var app = (0, express_1.default)();
app.use((0, helmet_1.default)());
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: false }));
app.use((0, morgan_1.default)("dev"));
app.set("view engine", "pug");
app.set("views", process.cwd() + "/src/views");
app.use("/public", express_1.default.static(path_1.default.join(process.cwd(), 'src', '/public')));
app.use('/', routes_1.default);
app.use('/user', user_1.default);
app.use('/plan', plan_1.default);
app.use('/post', post_1.default);
app.use('/comment', comment_1.default);
app.use('/category', category_1.default);
app.use(function (req, res, next) {
    var error = new tools_1.DamoyeoError("".concat(req.method, " ").concat(req.url, " \uB77C\uC6B0\uD130\uAC00 \uC5C6\uC2B5\uB2C8\uB2E4."), 404);
    next(error);
});
app.use(function (err, req, res, next) {
    var status = 500;
    var message = '알 수 없는 오류가 발생했습니다.';
    if (err instanceof tools_1.DamoyeoError) {
        status = err.status;
        message = err.message;
    }
    else {
        message = err.message;
        if (err.status) {
            status = err.status;
        }
    }
    res.status(status).json({
        opcode: tools_1.OPCODE.ERROR,
        message: message
    });
});
exports.default = app;
//# sourceMappingURL=app.js.map