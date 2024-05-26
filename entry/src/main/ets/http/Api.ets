import { instance } from './Axios';

//获取验证码
export function sendCode(phone: string) {
    return instance.get('/user/code', { params: { phone: phone } });
}
//登录
export function login(username: string, password: string) {
    return instance.post('/user/login', { username: username, password: password });
}

//获取个人信息
export function info() {
    return instance.get('/user/info')
}