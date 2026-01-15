interface Repository {
  id: string;
  name: string;
  fork: boolean;
}

async function getRepositories(): Promise<Repository[]> {
  const url = new URL("https://api.github.com/users/charlesfries/repos");

  // if (sort) {
  //   url.searchParams.append("sort", sort);
  // }
  // if (direction) {
  //   url.searchParams.append("direction", direction);
  // }

  const response = await fetch(url.href);
  if (!response.ok) {
    throw new Error("not ok");
  }

  const repositories = await response.json();

  return repositories;
}

export default async function Repositories() {
  const repositories = await getRepositories();

  return (
    <div className="grid grid-cols-3 gap-4">
      {repositories.map((repository) => (
        <div key={repository.id} className="p-4 border">
          {repository.name}
        </div>
      ))}
    </div>
  );
}
