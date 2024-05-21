import { instance } from './Axios';

//获取验证码
export function sendCode(phone: string) {
    return instance.get('/user/code', { params: { phone: phone } });
}
//登录
export function login(phone: string, code: string) {
    return instance.post('/word/user/login', { phone: phone, code: code });
}