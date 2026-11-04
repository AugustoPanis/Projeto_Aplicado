import { request } from "./api";

interface LoginResponse {
  token: string;
}

export async function login(
  email: string,
  password: string
): Promise<LoginResponse> {
  const data = await request<LoginResponse>("/auth/login", {
    method: "POST",
    body: JSON.stringify({ email, password }),
  });

  localStorage.setItem("token", data.token);
  return data;
}

export function logout(): void {
  localStorage.removeItem("token");
}

export function isAuthenticated(): boolean {
  return !!localStorage.getItem("token");
}