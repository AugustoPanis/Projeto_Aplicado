import { useNavigate } from "react-router-dom";
import { logout } from "../../services/authService";

export default function Dashboard() {
  const navigate = useNavigate();

  function handleLogout() {
    logout();
    navigate("/login");
  }

  return (
    <main>
      <h1>Dashboard</h1>
      <button onClick={handleLogout}>Sair</button>
    </main>
  );
}