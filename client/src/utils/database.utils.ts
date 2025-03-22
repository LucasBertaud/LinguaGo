import { AxiosResponse } from "axios";
import api from "./api.utils";

export const Database = {
  async get(collection: string, params?: object): Promise<AxiosResponse> {
    try {
      const response = await api.get(`/${collection}`, { params });
      return response;
    } catch (err) {
      console.error(err);
    }
  },

  async post(collection: string, item: object): Promise<AxiosResponse> {
    try {
      const response = await api.post(`/${collection}`, item);
      return response;
    } catch (err) {
      console.error(err);
    }
  },

  async patch(collection: string, item?: object, params?: object): Promise<AxiosResponse> {
    try {
      const response = await api.patch(`/${collection}`, item, { params });
      return response;
    } catch (error) {
      console.error(error);
    }
  },

  async delete(collection: string): Promise<AxiosResponse> {
    try {
      const response = await api.delete(`/${collection}`);
      return response;
    } catch (err) {
      console.error(err);
    }
  }
}