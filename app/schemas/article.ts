import { withDefaults } from '@warp-drive/core/reactive';
import type { Type } from '@warp-drive/core/types/symbols';
import { type WithLegacy } from '@warp-drive/legacy/model/migration-support';

export const ArticleSchema = withDefaults({
  type: 'article',
  fields: [
    { kind: 'field', name: 'type_of' },
    { kind: 'field', name: 'title' },
    { kind: 'field', name: 'description' },
    { kind: 'field', name: 'readable_publish_date' },
    { kind: 'field', name: 'slug' },
    { kind: 'field', name: 'path' },
    { kind: 'field', name: 'url' },
    { kind: 'field', name: 'comments_count' },
    { kind: 'field', name: 'public_reactions_count' },
    { kind: 'field', name: 'collection_id' },
    { kind: 'field', name: 'published_timestamp' },
    { kind: 'field', name: 'language' },
    { kind: 'field', name: 'subforem_id' },
    { kind: 'field', name: 'positive_reactions_count' },
    { kind: 'field', name: 'cover_image' },
    { kind: 'field', name: 'social_image' },
    { kind: 'field', name: 'canonical_url' },
    { kind: 'field', name: 'created_at' },
    { kind: 'field', name: 'edited_at' },
    { kind: 'field', name: 'crossposted_at' },
    { kind: 'field', name: 'published_at' },
    { kind: 'field', name: 'last_comment_at' },
    { kind: 'field', name: 'reading_time_minutes' },
    { kind: 'field', name: 'tag_list' },
    { kind: 'field', name: 'tags' },
    { kind: 'field', name: 'user' },
  ],
});

export type Article = WithLegacy<{
  type_of: string;
  title: string;
  description: string;
  readable_publish_date: string;
  slug: string;
  path: string;
  url: string;
  comments_count: number;
  public_reactions_count: number;
  collection_id: number | null;
  published_timestamp: string; // ISO date string
  language: null;
  subforem_id: null;
  positive_reactions_count: number;
  cover_image: string | null;
  social_image: string;
  canonical_url: string;
  created_at: string; // ISO date string
  edited_at: string | null;
  crossposted_at: string | null;
  published_at: string; // ISO date string
  last_comment_at: string; // ISO date string
  reading_time_minutes: number;
  tag_list: string[];
  tags: string;
  user: {
    name: string;
    username: string;
    twitter_username: string | null;
    github_username: string | null;
    user_id: number;
    website_url: string | null;
    profile_image: string;
    profile_image_90: string;
  };
  [Type]: 'article';
}>;
