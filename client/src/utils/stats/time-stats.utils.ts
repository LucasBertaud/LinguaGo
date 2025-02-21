export default class TimeStatsUtils {
    public seconds: number;

    constructor(seconds: number) {
        this.seconds = seconds;
    }

    private getMinutes(): number {
        return Math.floor(this.seconds / 60);
    }

    private getHours(): number {
        return Math.floor(this.seconds / 3600);
    }

    public getBestTimeTitle(): string {
        const hours = this.getHours();
        if(hours > 0) {
            return `Heure${hours > 1 ? 's' : ''}`;
        }

        const minutes = this.getMinutes();
        if(minutes > 0) {
            return `Minute${minutes > 1 ? 's' : ''}`;
        }

        return `Seconde${this.seconds > 1 ? 's' : ''}`;
    }

    public getBestTimeUnit(): string {
        const hours = this.getHours();
        if(hours > 0) {
            return `${hours}`;
        }

        const minutes = this.getMinutes();
        if(minutes > 0) {
            return `${minutes}`;
        }

        return `${this.seconds}`;
    }
}