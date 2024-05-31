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

export function uploadPlan(token: string, planName: string, isComplete: boolean, selectedDate: number) {
    return instance.post('plan/update', { token: token, planName: planName, isComplete: isComplete, selectedDate: selectedDate })
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

export function check(token: string, selectedDate: number, completedTime: number, todayTask: number, completedTask) {
    return instance.post('/user/check', { token: token , selectedDate: selectedDate, completedTime: completedTime, todayTask: todayTask, completedTask: completedTask})
}

export function deletePlan(token: string, selectedDate: number, planName: string){
    return instance.post('/plan/delete', { token: token, selectedDate: selectedDate, planName: planName })
}

export function getAllPost(page: number, size: number) {
    return instance.get('/post/getAll', { params: { page: page, size: size } })
}

export function like(postId: number) {
    return instance.get('/like/create', { params: { postId: postId } })
}

export function cancelLike(postId: number) {
    return instance.get('/like/cancel', { params: { postId: postId } })
}

export function getMyPost(page: number, size: number, token: string) {
    return instance.get('/post/mine', { params: { page: page, size: size, token: token} })
}

export function getCardList(token: string) {
    return instance.post('/achievement', { token: token })
}