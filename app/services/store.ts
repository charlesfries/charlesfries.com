import { JSONAPICache } from '@warp-drive/json-api';
import { useLegacyStore } from '@warp-drive/legacy';
import { DevCommunity } from 'charlesfries/handlers/dev-community';
import { GitHub } from 'charlesfries/handlers/github';
import { ArticleSchema } from 'charlesfries/schemas/article';
import { RepositorySchema } from 'charlesfries/schemas/repository';

const Store = useLegacyStore({
  linksMode: false,
  cache: JSONAPICache,
  handlers: [
    DevCommunity,
    GitHub,
    // -- your handlers here
  ],
  schemas: [
    RepositorySchema,
    ArticleSchema,
    // -- your schemas here
  ],
});

type Store = InstanceType<typeof Store>;

export default Store;
