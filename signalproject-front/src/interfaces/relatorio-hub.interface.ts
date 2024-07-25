export default interface IResponse {
    type: number;
    target: string;
    arguments: DadosValores[];
}

export interface DadosValores {
    [ano: string]: number;
}