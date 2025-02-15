import api from "./api";
import Cookies from 'js-cookie';

export default class Database {
  /**
   * -- General CRUD
   */
  static async getAll(collection: string, params?: object) {
    try {
      const response = await api.get(`/${collection}`, { params: params });
      return response.data;
    } catch (err) {
      console.log(err);
    }
  }

  static async getOne(collection: string, id: string, params?: object, headers?: object) {
    try {
      const response = await api.get(`/${collection}/${id}`, {
        params: params,
        headers: this.addAuthHeader(headers),
      });
      return response.data;
    } catch (err) {
      console.log(err);
    }
  }

  static async create(collection: string, item: object) {
    try {
      const response = await api.post(`/${collection}`, item, {
        headers: this.addAuthHeader(),
      });
      return {
        data: response.data,
        status: response.status
      }
    } catch (err) {
      console.log(err);
    }
  }

  static async update(collection: string, id: string, item: object) {
    try {
      const response = await api.patch(`/${collection}/${id}`, item, {
        headers: this.addAuthHeader(),
      });
      return response.data;
    } catch (err) {
      console.log(err);
    }
  }

  static async delete(collection: string, id: string) {
    try {
      const { status } = await api.delete(`/${collection}/${id}`, {
        headers: this.addAuthHeader(),
      });
      return status;
    } catch (err) {
      console.log(err);
    }
  }

  private static addAuthHeader(headers: object = {}) {
    const token = Cookies.get('access');
    if (token) {
      return { ...headers, Authorization: `Bearer ${token}` };
    }
    return headers;
  }
}