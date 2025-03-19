import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';

// 定义后端通用响应数据结构
export interface ApiResponse {
  success: boolean;
  message: string;
  data?: any;
}

// 首次请求标记，用于动态调整第一次请求的超时时间
let isFirstRequest = true;

const instance = axios.create({
  baseURL: 'https://wow.syoooo.top',
  timeout: 5000, // 基本超时时间保持不变
  headers: {
    'Content-Type': 'application/json'
  },
  withCredentials: false
});

// 请求拦截器
instance.interceptors.request.use(
  config => {
    // 为首次请求增加超时时间
    if (isFirstRequest) {
      config.timeout = 15000; // 首次请求超时时间设置为15秒
      isFirstRequest = false;
      console.log('首次请求，已增加超时时间至15秒');
    }
    return config;
  },
  error => {
    return Promise.reject(error);
  }
);

// 响应拦截器
instance.interceptors.response.use(
  response => {
    return response.data;
  },
  error => {
    console.error('请求错误:', error.message);
    // 特别处理超时错误
    if (error.code === 'ECONNABORTED' && error.message.includes('timeout')) {
      console.warn('请求超时，可能是首次连接导致的延迟');
    }
    return Promise.reject(error);
  }
);

export type ResponseHelper<T = unknown> = {
  success: boolean;
  message: string;
  data: T;
};

export type RequestConfig = Omit<AxiosRequestConfig, 'headers'> & {
  headers?: AxiosRequestConfig['headers'];
  retries?: number; // 添加重试次数配置
  retryDelay?: number; // 添加重试延迟配置
};

export default function request<T>(
  url: string,
  requestConfig?: RequestConfig
): Promise<AxiosResponse<ResponseHelper<T>>>;

export default function request<T>(url: string, config?: RequestConfig): Promise<T>;

export default function request<T>(
  url: string,
  requestConfig?: RequestConfig
): Promise<AxiosResponse<ResponseHelper<T>>> {
  // 设置默认重试配置
  const config = {
    ...requestConfig,
    retries: requestConfig?.retries || 2, // 默认重试2次
    retryDelay: requestConfig?.retryDelay || 1000 // 默认延迟1秒
  };

  // 重试计数器
  let retryCount = 0;

  // 创建请求函数
  const makeRequest = (): Promise<any> => {
    return new Promise((resolve, reject) => {
      instance(url, config)
        .then(res => {
          resolve(res.data);
        })
        .catch(err => {
          // 检查是否需要重试
          const shouldRetry =
            retryCount < config.retries &&
            (err.code === 'ECONNABORTED' || // 超时错误
             err.message.includes('timeout') || // 超时错误
             (err.response && (err.response.status === 502 || err.response.status === 503))); // 服务器错误

          if (shouldRetry) {
            retryCount++;
            console.log(`请求失败，正在进行第${retryCount}次重试...`);

            // 延迟重试
            setTimeout(() => {
              makeRequest()
                .then(resolve)
                .catch(reject);
            }, config.retryDelay);
          } else {
            reject(err);
          }
        });
    });
  };

  // 开始请求
  return makeRequest();
}
