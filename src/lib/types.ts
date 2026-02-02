export interface Post {
	id: number;
	title: string;
	slug: string;
	content: string;
	excerpt: string | null;
	published_at: string | null;
	featured_image: string | null;
	created_at: string;
	updated_at: string;
}

export interface Event {
	id: number;
	title: string;
	description: string | null;
	event_date: string;
	location: string | null;
	event_url: string | null;
	event_type: string | null;
	created_at: string;
	updated_at: string;
}

export interface Video {
	id: number;
	title: string;
	youtube_id: string;
	description: string | null;
	published_at: string | null;
	created_at: string;
	updated_at: string;
}

// Database types for Supabase
export interface Database {
	public: {
		Tables: {
			posts: {
				Row: Post;
				Insert: Omit<Post, 'id' | 'created_at' | 'updated_at'>;
				Update: Partial<Omit<Post, 'id' | 'created_at' | 'updated_at'>>;
			};
			events: {
				Row: Event;
				Insert: Omit<Event, 'id' | 'created_at' | 'updated_at'>;
				Update: Partial<Omit<Event, 'id' | 'created_at' | 'updated_at'>>;
			};
			videos: {
				Row: Video;
				Insert: Omit<Video, 'id' | 'created_at' | 'updated_at'>;
				Update: Partial<Omit<Video, 'id' | 'created_at' | 'updated_at'>>;
			};
		};
	};
}
