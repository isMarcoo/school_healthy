@Observed
export class PostInfo {
    id : number;
    postText : string;
    completedTask : number;
    todayTask : number;
    completedTime : number;
    createTime : string;
    likeCount : number;
    username : string;
    avatarUrl : string;
    isLike : boolean;

    constructor(post:{id: number, postText: string, completedTask: number, todayTask: number, completedTime: number, createTime : string, likeCount : number, username : string, avatarUrl : string, isLike : boolean}) {
        this.id = post.id;
        this.postText = post.postText;
        this.completedTask = post.completedTask;
        this.todayTask = post.todayTask;
        this.completedTime = post.completedTime;
        this.createTime = post.createTime;
        this.likeCount = post.likeCount;
        this.username = post.username;
        this.avatarUrl = post.avatarUrl;
        this.isLike = post.isLike;
    }
}