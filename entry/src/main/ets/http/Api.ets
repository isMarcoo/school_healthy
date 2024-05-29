import { PlanItem } from '../model/PlanItem';
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
export function info(token: string) {
    return instance.get('/user/info', { params: { token: token } })
}

export function register(username: string, password: string) {
    return instance.post('/user/register', { username: username, password: password })
}

export function getPlanList(token: string, selectedDate: number) {
    return instance.post('/plan/list', {  token: token, selectedDate: selectedDate })
}

export function addPlan(token: string, selectedDate: number, planName: string, planCost: number) {
    return instance.post('/plan/add', { token: token, selectedDate: selectedDate, planName: planName, planCost: planCost })
}

export function uploadPlan(token: string, totalData: Array<PlanItem>, selectedDate: number) {
    return instance.post('plan/update', { token: token, totalData: totalData, selectedDate: selectedDate })
}

export function getTimeByDay(token: string, selectedDate: number) {
    return instance.post('plan/stats/day', { token: token, selectedDate: selectedDate })
}

export function getTime(token: string) {
    return instance.post('/plan/stats/all', { token: token })
}

export function getConsecutiveDay(token: string) {
    return instance.post('/user/consecutive', { token: token })
}

export function check(token: string) {
    return instance.post('/user/check', { token: token })
}

export function deletePlan(token: string, selectedDate: number, planName: string){
    return instance.post('/plan/delete', { token: token, selectedDate: selectedDate, planName: planName })
}