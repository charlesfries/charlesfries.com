// TODO: duplicated
type Sort = 'created' | 'updated' | 'pushed' | 'name';
type Direction = 'asc' | 'desc';

const SORT_MAP = {
  created: 'CREATED_AT',
  updated: 'UPDATED_AT',
  pushed: 'PUSHED_AT',
  name: 'NAME',
};

const DIRECTION_MAP = {
  asc: 'ASC',
  desc: 'DESC',
};

export default async (request: Request) => {
  const gql = String.raw;
  const query = gql`
    query GetRepositories(
      $sort: RepositoryOrderField!
      $direction: OrderDirection!
      $first: Int
      $last: Int
      $after: String
      $before: String
    ) {
      user(login: "charlesfries") {
        repositories(
          first: $first
          last: $last
          after: $after
          before: $before
          orderBy: { field: $sort, direction: $direction }
        ) {
          pageInfo {
            hasNextPage
            hasPreviousPage
            first: startCursor
            last: endCursor
          }
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
    const _sort = url.searchParams.get('sort') as Sort | null;
    const _direction = url.searchParams.get('direction') as Direction | null;
    const after = url.searchParams.get('after');
    const before = url.searchParams.get('before');

    const sort = SORT_MAP[_sort ?? 'pushed'];
    const direction = DIRECTION_MAP[_direction ?? 'desc'];
    const pageSize = 32;
    const isBackwardPagination = Boolean(before);

    const variables = {
      sort,
      direction,
      first: isBackwardPagination ? null : pageSize,
      last: isBackwardPagination ? pageSize : null,
      after: isBackwardPagination ? null : after,
      before: isBackwardPagination ? before : null,
    };

    const response = await fetch('https://api.github.com/graphql', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.GITHUB_TOKEN}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query, variables }),
    });

    const data = await response.json();

    if (!response.ok || data.errors) {
      console.error(data);
      return new Response(JSON.stringify(data.errors ?? data), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const repositories = data.data.user.repositories.nodes as { id: string }[];
    const pageInfo = data.data.user.repositories.pageInfo as {
      hasNextPage: boolean;
      hasPreviousPage: boolean;
      first: string | null;
      last: string | null;
    };

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

    const body = {
      data: repositories.map(({ id, ...attributes }) => ({
        type: 'repository',
        id,
        attributes,
      })),
      meta: {
        hasMore: isBackwardPagination
          ? pageInfo.hasPreviousPage
          : pageInfo.hasNextPage,
        first: pageInfo.first,
        last: pageInfo.last,
      },
    };

    return new Response(JSON.stringify(body), { headers });
  } catch (error) {
    console.error(error);
    return new Response('Error', { status: 500 });
  }
};
