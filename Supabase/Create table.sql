DROP TABLE IF EXISTS public.recipes CASCADE;

CREATE TABLE public.recipes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  image_url VARCHAR(255),

  category_id INTEGER REFERENCES public.categories(id) ON DELETE SET NULL,
  category VARCHAR(255),

  author_id UUID REFERENCES auth.users(id) ON DELETE CASCADE, -- ✅ match Dart's currentUserId
  author_name VARCHAR(255),
  author_avatar_url VARCHAR(255),

  cooking_time VARCHAR(100),
  serving_size VARCHAR(50), -- ✅ new column
  calories VARCHAR(100),
  short_description TEXT,
  ingredients JSONB,
  directions TEXT[]
);

ALTER TABLE public.recipes
ADD COLUMN user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
