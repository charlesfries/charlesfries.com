import type { Document } from 'jsonapi-typescript';

// success

type Body = {
  data: {
    user: {
      repositories: {
        nodes: {
          id: string;
          name: string;
          description: string | null;
          url: string;
          stargazerCount: number;
          forkCount: number;
          isFork: boolean;
          pushedAt: string | null;
          primaryLanguage: {
            name: string;
          } | null;
        }[];
      };
    };
  };
};

// error

type ErrorBody = {
  errors: {
    message: string;
    extensions?: {
      value?: string;
      problems?: {
        path: (string | number)[];
        explanation: string;
      }[];
    };
  }[];
};

export default async (request: Request) => {
  const gql = String.raw;
  const query = gql`
    query GetRepositories(
      $sort: RepositoryOrderField!
      $direction: OrderDirection!
    ) {
      user(login: "charlesfries") {
        repositories(
          first: 30
          orderBy: { field: $sort, direction: $direction }
        ) {
          nodes {
            id
            name
            description
            url
            stargazerCount
            forkCount
            isFork
            pushedAt
            primaryLanguage {
              name
            }
          }
        }
      }
    }
  `;

  try {
    const url = new URL(request.url);
    const sort = url.searchParams.get('sort') ?? 'PUSHED_AT';
    const direction = url.searchParams.get('direction') ?? 'DESC';

    const variables = { sort, direction };

    const response = await fetch('https://api.github.com/graphql', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.GITHUB_TOKEN}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query, variables }),
    });

    const data = (await response.json()) as Body | ErrorBody;

    if (!response.ok || (data as ErrorBody).errors) {
      console.error(data);
      let body: Document;
      if ((data as ErrorBody).errors) {
        body = {
          errors: (data as ErrorBody).errors.map((error) => ({
            detail:
              error.extensions?.problems?.[0]?.explanation ?? error.message,
          })),
        };
      } else {
        body = data as any;
      }
      return new Response(JSON.stringify(body), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const repositories = (data as Body).data.user.repositories.nodes;

    const headers = new Headers();
    headers.set('Content-Type', 'application/json');

    const forwardHeaders = [
      'X-RateLimit-Remaining',
      'X-RateLimit-Limit',
      'X-RateLimit-Reset',
    ];

    for (const name of forwardHeaders) {
      const value = response.headers.get(name);
      if (value) {
        headers.set(name, value);
      }
    }

    const body: Document = {
      data: repositories.map(({ id, ...attributes }) => ({
        type: 'repository',
        id,
        attributes,
      })),
    };

    return new Response(JSON.stringify(body), { headers });
  } catch (error) {
    console.error(error);
    return new Response('Error', { status: 500 });
  }
};
