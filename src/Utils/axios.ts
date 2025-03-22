import axios, { AxiosRequestConfig, InternalAxiosRequestConfig } from 'axios';

// 定义后端通用响应数据结构
export interface ApiResponse {
  success: boolean;
  message: string;
  data?: any;
}

// 定义重试配置接口
interface RetryConfig {
  maxRetries: number;
  retryDelay: number;
  currentRetry: number;
}

// 扩展AxiosRequestConfig类型
interface CustomAxiosRequestConfig extends InternalAxiosRequestConfig {
  retryConfig: RetryConfig;
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

// 创建延迟函数
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

// 判断是否需要重试的条件
const isRetryableError = (error: any) => {
  // 网络错误或服务器错误(5xx)时进行重试
  return axios.isAxiosError(error) && (
    !error.response ||
    (error.response.status >= 500 && error.response.status <= 599)
  );
};

// 请求拦截器
instance.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 初始化重试配置
    (config as CustomAxiosRequestConfig).retryConfig = {
      maxRetries: 3,
      retryDelay: 1000,
      currentRetry: 0
    };
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
  async error => {
    const config = error.config as CustomAxiosRequestConfig;

    // 如果没有配置对象，直接拒绝
    if (!config) {
      return Promise.reject(error);
    }

    // 如果已达到最大重试次数，直接拒绝
    if (config.retryConfig.currentRetry >= config.retryConfig.maxRetries) {
      if (error?.response?.data) {
        return Promise.reject(error.response.data);
      }
      return Promise.reject(error);
    }

    // 判断是否需要重试
    if (isRetryableError(error)) {
      config.retryConfig.currentRetry += 1;

      // 计算延迟时间（可以使用指数退避策略）
      const delayTime = config.retryConfig.retryDelay;

      // 等待延迟时间后重试
      await delay(delayTime);

      // 重试请求
      return instance(config);
    }

    // 不满足重试条件，直接拒绝
    if (error?.response?.data) {
      return Promise.reject(error.response.data);
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
