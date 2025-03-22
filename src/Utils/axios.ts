import axios, { AxiosRequestConfig } from 'axios';

// 定义后端通用响应数据结构
export interface ApiResponse {
  success: boolean;
  message: string;
  data?: any;
}

const instance = axios.create({
  baseURL: 'https://wow-api.syoooo.top',
  // baseURL: 'http://localhost:8787',
  // baseURL: 'https://wow-api.syoooo.workers.dev',
  timeout: 5000, // 基本超时时间保持不变
  headers: {
    'Content-Type': 'application/json'
  },
  withCredentials: false
});

// 请求拦截器
instance.interceptors.request.use(
  config => {
    return config;
  },
  error => {
    return Promise.reject(error);
  }
);

// 响应拦截器
instance.interceptors.response.use(
  response => {
    return response;
  },
  error => {
    if (error?.response?.data) {
      return Promise.reject(error.response.data);
    } else {
      return Promise.reject(error);
    }
  }
);

export type ResponseHelper<T = unknown> = {
  success: boolean;
  message: string;
  data: T;
};

export type RequestConfig = Omit<AxiosRequestConfig, 'headers'> & {
  headers?: AxiosRequestConfig['headers'];
};

// 修改函数重载声明
export default function request<T>(url: string, requestConfig?: RequestConfig): Promise<T>;

export default function request<T>(url: string, requestConfig?: RequestConfig): Promise<T> {
  const config = {
    ...requestConfig
  };

  // 创建请求函数
  const makeRequest = (): Promise<T> => {
    return new Promise((resolve, reject) => {
      instance(url, config)
        .then(res => {
          resolve(res.data);
        })
        .catch(err => {
          reject(err);
        });
    });
  };

  // 开始请求
  return makeRequest();
}
