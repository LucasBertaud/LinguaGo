import api from "./api";

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

  static async getOne(collection: string, id: string, params?: object) {
    try {
      const response = await api.get(`/${collection}/${id}`, {
        params: params,
      });
      return response.data;
    } catch (err) {
      console.log(err);
    }
  }

  static async create(collection: string, item: object) {
    try {
      const response = await api.post(`/${collection}`, item);
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
      const response = await api.patch(`/${collection}/${id}`, item);
      return response.data;
    } catch (err) {
      console.log(err);
    }
  }

  static async delete(collection: string, id: string) {
    try {
      const { status } = await api.delete(`/${collection}/${id}`);
      return status;
    } catch (err) {
      console.log(err);
    }
  }
}