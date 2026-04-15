import { JSONAPICache } from '@warp-drive/json-api';
import { useLegacyStore } from '@warp-drive/legacy';
import { RepositorySchema } from 'charlesfries/schemas/repository';

const Store = useLegacyStore({
  linksMode: false,
  cache: JSONAPICache,
  handlers: [
    // -- your handlers here
  ],
  schemas: [
    RepositorySchema,
    // -- your schemas here
  ],
});

type Store = InstanceType<typeof Store>;

export default Store;
