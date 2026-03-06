UPDATE posts
SET content = REPLACE(
  content,
  'https://www.youtube.com/@odysseas__',
  '<https://www.youtube.com/@odysseas__>'
)
WHERE slug = 'the-accidental-quest-to-become-a-modern-polymath';
